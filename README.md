Get the updated posts from Notion.

```
gh issue create -t "test notion-ci" -b ""

gh workflow run 'Notion to Blog'
gh workflow run  'Generate Checkin Charts'
```

## Development
```
hugo server -D

```
