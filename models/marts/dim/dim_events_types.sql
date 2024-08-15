SELECT DISTINCT
    type AS event_type,
    CASE 
        WHEN type = 'PullRequestEvent' THEN 'Pull Request'
        WHEN type = 'PushEvent' THEN 'Push'
        ELSE 'Other'
    END AS event_category
FROM {{ ref('stg_raw_events') }}
