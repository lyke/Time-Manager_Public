#!/bin/bash
# Docker entrypoint script.
# Wait until Postgres is ready
cd /app/time_manager

mix deps.get

mix ecto.create
# mix phx.gen.schema User users first_name:string last_name:string
# mix phx.gen.schema Task tasks title:string description:string status:string user_id:references:users

mix ecto.migrate

mix phx.server
