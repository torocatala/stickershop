# Use the Ruby 3.2.2 image with Alpine Linux 
FROM ruby:latest

# Set environment variables
ENV RAILS_ENV production
ENV RACK_ENV production

# Install Rails 
RUN gem install rails -v 7.0.6

# Create app directory
WORKDIR /app

# Copy Gemfile*
COPY Gemfile* . 

# Install gems 
RUN bundle install

# Copy app 
COPY . .

# Build assets 
RUN rails assets:precompile

# Set port 
EXPOSE 3000

# Run server
CMD ["rails", "s", "-p", "3000",  "-b", "0.0.0.0"]
