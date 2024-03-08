FROM node:16 as builder

WORKDIR /usr/local/app
 
RUN mkdir -p /tmp/go && \
  curl -fsSL -o /tmp/go/go.tar.gz https://go.dev/dl/go1.22.1.linux-amd64.tar.gz  && \
  tar -C /usr/local -xzf /tmp/go/go.tar.gz

COPY . .

RUN npm install --legacy-peer-deps

ENV PATH="${PATH}:/usr/local/go/bin"
ENV PUBLIC_URL="/"

RUN npm run build


FROM nginx

COPY --from=builder /usr/local/app/build /usr/share/nginx/html
