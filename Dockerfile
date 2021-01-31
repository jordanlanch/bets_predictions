FROM bitwalker/alpine-elixir-phoenix:latest

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile
RUN mix do ecto.create, ecto.migrate

# Same with npm deps
ADD assets/package.json assets/
RUN cd assets && npm install

CMD ["mix", "phx.server"]