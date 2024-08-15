WITH filtered_events AS (
    SELECT *
    FROM {{ ref('stg_raw_events') }}
    WHERE type IN ('PullRequestEvent', 'PushEvent', 'CreateEvent', 'WatchEvent', 'IssueCommentEvent', 'PullRequestReviewEvent')
)
SELECT
    actor_display_login,
    type,
    COUNT(*) OVER (PARTITION BY actor_display_login) AS actor_event_count
FROM filtered_events
