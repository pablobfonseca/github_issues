# Github Issues

## Usage:
```ruby
GithubIssues.new({org: 'rails', repo: 'rails', status: 'open'}).report
```

## Initial Params
```ruby
options = {
  org: '', # Organization name (i.e: 'rails')
  repo: '', # Repository name (i.e: 'rails')
  status: '' # Issue status ('open/closed')
}
```

## Response example:
```ruby
[
  "Issue ActionController::Metal response includes the default headers",
  "Issue Backport #25771 to 5-0-stable", "Issue Check `request.path_parameters` encoding at the point they're set",
  "Issue Add newline between each migration in `structure.sql`",
  "Issue private_constant macro dosn't work with ActiveSupport::Autoload",
  "Issue Added :fallback_string option to Array#to_sentence",
  "Issue Quoting of default values in Mysql2 adapter"
  ]
```
