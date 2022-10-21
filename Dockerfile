FROM cypress/included:10.10.0

# APP ALIAS
ENV APP_ALIAS='jenkins'

RUN apt install -y jq

RUN useradd --create-home --shell /bin/bash jenkins

COPY . /e2e
WORKDIR /e2e
RUN chown -R jenkins:jenkins /e2e


USER jenkins:jenkins

ENV PATH "$PATH:/usr/local/bin:/usr/bin"

RUN npm install
# RUN cypress run

# RUN jq ${APP_ALIAS} /e2e/cypress.env.json .APP_ALIAS
# CMD [ "npm install" ]

CMD [ "/usr/local/bin/cypress", "run" ]
ENTRYPOINT [ "/usr/local/bin/cypress", "run" ]
# ENTRYPOINT [ "/bin/bash" ]