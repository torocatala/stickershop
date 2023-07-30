# Use the Ruby 3.2.2 image with Alpine Linux 
FROM ruby:latest

# Create a non-root user 'rubyuser'
RUN adduser --disabled-password --gecos "" rubyuser

# Set environment variables
ENV RAILS_ENV production
ENV RACK_ENV production

# Create app directory and set proper permissions
RUN mkdir -p /app && chown -R rubyuser:rubyuser /app
WORKDIR /app

# Switch to the 'rubyuser'
USER rubyuser

# Install Rails and gems
RUN gem install rails -v 7.0.6 && gem install bundler

# Copy Gemfile*
COPY --chown=rubyuser:rubyuser Gemfile* . 

# Install gems in vendor directory
RUN bundle config set path 'vendor/bundle' && bundle install

# Copy the rest of the app as 'rubyuser'
COPY --chown=rubyuser:rubyuser . .

# Build assets 
RUN rails assets:precompile

# Set permissions for vendor directory
RUN chown -R rubyuser:rubyuser /app/vendor

# Set port 
EXPOSE 3001

# Run server
CMD ["rails", "s", "-p", "3001",  "-b", "0.0.0.0"]
