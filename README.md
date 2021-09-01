# README

Databases for dev/testing is dockerized in a single Postgres instance.

Endpoints: 
    
    POST: "/create_user_events"
        - create a user event according to the spec.
    
    
    GET: "/todays_stats
        - get stats for today's events
        - I would have rewritten this endpoint to be more generic, just taking in
            a date as a param.
