# renovate-gitlab-ci
Run [renovate](https://github.com/renovatebot/renovate) as a [gitlab-ci](https://docs.gitlab.com/ee/ci/) job.

## Why
So far renovate can be consumed in two variants: as a service for publicly available Gitlab instances or self-hosted on any machine having access to your Gitlab instance. While the later is working quite fine, setting and maintaining it for just one or two projects may be overpowered.

For these cases this image can be used to run renovate periodically in gitlab-ci.

## Usage

You will need to setup a renovate config like in all other setups: [Renovate Docs / Configuration Options](https://docs.renovatebot.com/configuration-options/)

Renovate will read it's config always from master-branch. So make sure you merged it. 

We'd recommend settings `"prHourlyLimit": 10` and `"prConcurrentLimit": 1` to keep cpu load manageable.

### Add job to gitlab-ci.yml
Add following lines to your `gitlab-ci.yml`: 
```yml
renovate:
  image:
    name: mortimmer/renovate-gitlab-ci
  script:
    - do-renovate
  only:
    refs:
      - schedules
    variables:
      - $WHICH_SCHEDULE == "renovate"
```

### Add access token
Renovate will need to act on you behalf so we will need to generate an access token. Ideally you will create a new user for renovate. Create a token with `api` scope.

### Add scheduled job
Once your `gitlab-ci.yml` is pushed you can create a scheduled pipeline (Gitlab-Menu: CI/CD / Schedules / New schedule). Set fields like this:

```yaml
"Description": Renovate
"Interval Pattern": (Custom) 0 * * * *  
"Cron Timezone": UTC
"Target Branch": (branch with your modified gitlab-ci.yml)
"Variables":
    WHICH_SCHEDULE: renovate
    RENOVATE_TOKEN: (your gitlab access token)
```

Hit save. This will run renovate hourly.

## Disadvantages to running renovate the usual way
Renovate is not meant to run periodically but rather triggered via hooks on repository changes. This means things like automatic rebasing won't work properly with this approach.

Also if you are running many projects, this approach spins up periodically docker images for every project. This consume radically more cpu than running renovate as a service. In that chase you may want to consider changing to "the usual way" to save resources for your actual builds on gitlab-ci.
