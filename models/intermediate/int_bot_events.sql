WITH bot_events AS (
    SELECT
        actor_login,
        type,
        COUNT(*) AS bot_event_count
    FROM {{ ref('stg_raw_events') }}
    WHERE actor_login LIKE '%[bot]%'
    GROUP BY actor_login, type
),
non_bot_events AS (
    SELECT
        actor_login,
        type,
        COUNT(*) AS non_bot_event_count
    FROM {{ ref('stg_raw_events') }}
    WHERE actor_login NOT LIKE '%[bot]%'
    GROUP BY actor_login, type
)
SELECT 
    COALESCE(bot.actor_login, non_bot.actor_login) AS actor_login,
    COALESCE(bot.type, non_bot.type) AS type,
    COALESCE(bot.bot_event_count, 0) AS bot_event_count,
    COALESCE(non_bot.non_bot_event_count, 0) AS non_bot_event_count
FROM bot_events bot
FULL OUTER JOIN non_bot_events non_bot  -- Correct alias here
ON bot.actor_login = non_bot.actor_login
   AND bot.type = non_bot.type
