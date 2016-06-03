FROM ruby

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /opt

ADD Gemfile Gemfile
RUN bundle install

ADD config config
ADD log/.git_keep log/.git_keep

COPY upload upload
ADD app.rb app.rb
ADD config.ru config.ru

EXPOSE 1337
CMD puma -p 1337

