FROM zemanlx/remark-lint:0.1.2

RUN npm install remark-lint-no-trailing-spaces@2.0.0

WORKDIR /lint

COPY .remarkrc.yml ./

WORKDIR /lint/input
