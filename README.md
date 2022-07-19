<div align="center">
  <a href="https://github.com/NetaMx/moe-workflows">
    <img src="./Neta.png" alt="Logo" width="150" height="100">
  </a>

  <h3 align="center">Neta Workflows Configuration</h3>
</div>

## Getting Started

1. Create your Feature Branch (`git checkout -b feature/[JIRA-ID]`)
2. Commit your Changes (`git commit -m '[JIRA-ID]'`)
3. Push to the Branch (`git push origin feature/[JIRA-ID]`)
4. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>

### usage

```yaml
name: Deploy 🚀

on:
  workflow_dispatch:
  push:
    branches: [develop]

jobs:
  release:
    uses: NetaMx/moe-workflows/.github/workflows/release.yml@main
    secrets:
      github-token: ${{ secrets.GITHUB_TOKEN }}

  build-image-dev:
    if: github.event.ref == 'refs/heads/develop'
    needs: [release]
    uses: NetaMx/moe-workflows/.github/workflows/build-image.yml@main
    with:
      dev_env: develop
    secrets:
      ecr_repository: ${{ secrets.ECR_REPOSITORY }}
      region: ${{ secrets.AWS_REGION }}
      aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

  deploy-argocd-dev:
    if: github.event.ref == 'refs/heads/develop'
    needs: [build-image-dev]
    uses: NetaMx/moe-workflows/.github/workflows/git-ops.yml@main
    with:
      dev_env: develop
      branch-name: main
    secrets:
      github-token: ${{ secrets.GITHUB_TOKEN }}
      ecr_repository: ${{ secrets.ECR_REPOSITORY }}

  slack-message:
    if: ${{ always() }}
    needs: [deploy-argocd-dev]
    uses: NetaMx/moe-workflows/.github/workflows/slack.yml@main
    secrets:
      slack_webhook: ${{ secrets.SLACK_WEBHOOK }}
```

<!-- CONTACT -->
## Contact

* Adrian - [@adrianhorizon](https://github.com/adrianhorizon)

__Project Link:__ [https://github.com/NetaMx/moe-workflows](https://github.com/NetaMx/moe-workflows)

<p align="right">(<a href="#top">back to top</a>)</p>
