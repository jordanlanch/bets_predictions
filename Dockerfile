FROM bitwalker/alpine-elixir-phoenix:latest

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix local.rebar
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/
RUN cd assets && npm install

EXPOSE 4000
CMD ["mix", "phx.server"]