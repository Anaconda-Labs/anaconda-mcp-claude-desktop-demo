# Automated Status Badge Setup

This repository uses automated GitHub Actions badges to show repository status and activity.

## What We're Using

1. **Status Badge**: Shows if the repository workflow is passing (green = active)
2. **Last Commit Badge**: Automatically updates with the date of the last commit

## How It Works

### The Workflow File

`.github/workflows/status.yml` runs on:
- Every push to main
- Every pull request
- Weekly schedule (Monday 9am UTC) to keep badge green
- Manual trigger via workflow_dispatch

The workflow does a simple check to verify the repository is active.

### The Badges

In the README:

```markdown
[![Status](https://img.shields.io/github/actions/workflow/status/anaconda-labs/REPO-NAME/status.yml?branch=main&label=status)](https://github.com/anaconda-labs/REPO-NAME/actions/workflows/status.yml)
[![Last Commit](https://img.shields.io/github/last-commit/anaconda-labs/REPO-NAME)](https://github.com/anaconda-labs/REPO-NAME/commits/main)
```

Replace `REPO-NAME` with your repository name.

## Adding to Other Repositories

### Step 1: Copy the Workflow File

1. Create `.github/workflows/` directory in your repo
2. Copy the `status.yml` file from this repository
3. Commit and push

### Step 2: Add Badges to README

Add these lines near the top of your README (replace `REPO-NAME`):

```markdown
[![Status](https://img.shields.io/github/actions/workflow/status/anaconda-labs/REPO-NAME/status.yml?branch=main&label=status)](https://github.com/anaconda-labs/REPO-NAME/actions/workflows/status.yml)
[![Last Commit](https://img.shields.io/github/last-commit/anaconda-labs/REPO-NAME)](https://github.com/anaconda-labs/REPO-NAME/commits/main)
```

### Step 3: Wait for First Run

- The workflow will run automatically on your next push
- Or trigger it manually: Go to Actions → Status Check → Run workflow
- Badges will update within a few minutes

## Customization

### Change Schedule

Edit the cron expression in `status.yml`:

```yaml
schedule:
  - cron: '0 9 * * 1'  # Weekly Monday 9am UTC
```

Examples:
- Daily: `'0 9 * * *'`
- Bi-weekly: `'0 9 1,15 * *'`
- Monthly: `'0 9 1 * *'`

### Additional Badges

You can add more shields.io badges:

```markdown
[![License](https://img.shields.io/github/license/anaconda-labs/REPO-NAME)](LICENSE)
[![Issues](https://img.shields.io/github/issues/anaconda-labs/REPO-NAME)](https://github.com/anaconda-labs/REPO-NAME/issues)
[![Stars](https://img.shields.io/github/stars/anaconda-labs/REPO-NAME)](https://github.com/anaconda-labs/REPO-NAME/stargazers)
```

## Future: Org-Wide Reusable Workflow

Once this pattern is proven, we can create a centralized reusable workflow:

1. Create `anaconda-labs/.github` repository (org-wide templates)
2. Add reusable workflow: `.github/workflows/status-check.yml`
3. Each repo's workflow becomes a 5-line file that calls the central one

Benefits:
- Update logic in one place
- All repos inherit changes automatically
- Consistent behavior across organization

## Troubleshooting

**Badge shows "failing"**:
- Check Actions tab for error details
- Ensure workflow file has no syntax errors
- Verify repository has Actions enabled (Settings → Actions)

**Badge shows "unknown"**:
- Wait for first workflow run
- Check repository name in badge URL matches actual repo
- Verify workflow file is named `status.yml`

**Badge doesn't update**:
- Shields.io caches for ~5 minutes
- Force refresh: Add `?timestamp=UNIX_TIMESTAMP` to badge URL temporarily
- Check workflow has run recently (Actions tab)

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Shields.io Badge Generator](https://shields.io/)
- [Cron Expression Generator](https://crontab.guru/)
