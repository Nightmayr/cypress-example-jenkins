FROM cypress/included:10.10.0

# APP ALIAS
ENV APP_ALIAS='jenkins'

RUN apt install -y jq

RUN useradd --create-home --shell /bin/bash jenkins

COPY . /e2e
WORKDIR /e2e
RUN chown -R jenkins:jenkins /e2e


USER jenkins:jenkins

RUN npm install
# RUN cypress run

# RUN jq ${APP_ALIAS} /e2e/cypress.env.json .APP_ALIAS
# CMD [ "npm install" ]

ENTRYPOINT [ "cypress run" ]
# ENTRYPOINT [ "/bin/bash" ]