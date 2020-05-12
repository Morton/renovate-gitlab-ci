FROM renovate/renovate:19.181

WORKDIR "/usr/src/app/"
COPY do-rebase .
COPY do-renovate .
ENV PATH="/usr/src/app/:${PATH}"

# COPY package.json .
# COPY package-lock.json .

# RUN npm install

ENTRYPOINT bash
