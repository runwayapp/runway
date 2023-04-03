#!/usr/bin/env puma
# frozen_string_literal: true

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
threads 0, 16

# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
port ENV.fetch('PORT', 3000)

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
# https://github.com/puma/puma#clustered-mode
workers 3
preload_app!

# Load metrics plugin
plugin 'metrics'
