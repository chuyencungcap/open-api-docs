FROM ruby:2.4.1-onbuild

WORKDIR /src/open-api-docs

RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list

RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get install -y nodejs \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

ADD . /src/open-api-docs/

RUN bundle exec middleman build --clean

FROM nginx
RUN sed -i '/access_log/c\    access_log off;' /etc/nginx/nginx.conf
COPY --from=builder /src/open-api-docs/build /usr/share/nginx/html/
