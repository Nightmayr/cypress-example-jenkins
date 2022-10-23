FROM cypress/included:10.10.0

# APP ALIAS
ENV APP_ALIAS='jenkins'

RUN apt install -y jq moreutils

RUN groupadd -g 974 jenkins
RUN groupadd -g 975 docker
RUN useradd jenkins -u 974 -g 974 --create-home --shell /bin/bash
RUN useradd docker -u 975 -g 975 --create-home --shell /bin/bash


COPY . /e2e
WORKDIR /e2e
RUN chown -R jenkins:jenkins /e2e


USER jenkins:jenkins

ENV PATH="$PATH:/usr/local/bin:/usr/bin"

RUN npm ci
RUN cat cypress.env.json | jq --arg APP_ALIAS $APP_ALIAS 'select (.APP_ALIAS == "f1") .APP_ALIAS = $APP_ALIAS' | sponge cypress.env.json
# RUN cypress run

# RUN jq ${APP_ALIAS} /e2e/cypress.env.json .APP_ALIAS
# CMD [ "npm install" ]

# CMD [ "/usr/local/bin/cypress", "run" ]
# ENTRYPOINT [ "/usr/local/bin/cypress", "run" ]
# ENTRYPOINT [ "cypress", "run" ]
# ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT []