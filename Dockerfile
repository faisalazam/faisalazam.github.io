# Use the official Jekyll image as the base
FROM jekyll/jekyll:4.2.2

# Set environment variables
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JEKYLL_ENV=development \
    GEM_PATH=/usr/gem/gems

# Set the working directory to /srv/jekyll
WORKDIR /srv/jekyll

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install the required gems
RUN gem install bundler && bundle install

# Ensure the working directory has the correct ownership
RUN chown -R jekyll:jekyll /srv/jekyll

# Expose ports
EXPOSE 4000 35729

# Command to initialize and run Jekyll with livereload
CMD ["/bin/sh", "-c", "\
    if [ ! -f _config.yml ]; then \
        echo 'No _config.yml found. Initializing a new Jekyll site...'; \
        jekyll new . --force; \
    fi; \
    echo 'Starting Jekyll server with livereload...'; \
    jekyll serve --host 0.0.0.0 --incremental --livereload --force_polling \
"]
