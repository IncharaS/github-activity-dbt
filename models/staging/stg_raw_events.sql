SELECT
    type,
    COALESCE(actor_display_login, 'Unknown') AS actor_display_login,
    COALESCE(actor_login, 'Unknown') AS actor_login,
    COALESCE(actor_id, 'Unknown') AS actor_id
FROM {{ source('source_database', 'my_table') }}

