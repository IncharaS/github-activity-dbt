SELECT
    actor_display_login,
    COUNT(*) AS total_events,
    COUNT(CASE WHEN type = 'PullRequestEvent' THEN 1 END) AS pull_request_events,
    COUNT(CASE WHEN type = 'PushEvent' THEN 1 END) AS push_events
FROM {{ ref('int_cleaned_events') }}
GROUP BY actor_display_login
ORDER BY total_events DESC
