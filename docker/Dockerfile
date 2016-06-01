FROM ruby

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /opt

ADD Gemfile Gemfile
RUN bundle install

ADD lib lib
ADD config config
ADD log/.git_keep log/.git_keep

ADD app.rb app.rb
ADD config.ru config.ru

EXPOSE 3000
CMD puma -p 3000
