# AWS Access Reference

Personal cheat sheet for AWS Identity Center + CLI access.
Account holder: hi1906

---

## Identity & Access Architecture

| Layer | Identity | MFA | Use For |
|---|---|---|---|
| **Root** | Account email + password | YubiKey (primary + backup) | Emergency only — billing, account closure, root-only tasks |
| **Identity Center user** | `hi1906` via access portal | YubiKey (primary + backup) | All daily work (console + CLI) |
| **CLI profile** | `hiaws` (SSO-backed) | Inherits from IC session | Terminal / scripts / IaC |

**No static IAM access keys exist on this account or this machine.**

---

## Console Access (Browser)

### Daily login
1. Open the AWS access portal URL: `https://d-90660a8803.awsapps.com/start`
2. Sign in with Identity Center user: `hi1906`
3. Complete MFA with YubiKey
4. Click your AWS account → click `AdministratorAccess` → opens console as federated SSO role

### Root login (emergencies only)
1. Go to https://signin.aws.amazon.com/
2. Choose **Root user** → enter root email + password
3. Complete MFA with YubiKey

---

## CLI Access (Terminal)

### Profile name: `hiaws`

### First-time setup (already done — for rebuilds)
```bash
aws configure sso
```

| Prompt | Answer |
|---|---|
| SSO session name | `personal` |
| SSO start URL | `https://d-xxxxxxxxxx.awsapps.com/start` |
| SSO region | `us-east-1` |
| SSO registration scopes | (Enter for default) |
| AWS account | (select your account) |
| Role | `AdministratorAccess` |
| CLI default region | `us-east-1` |
| CLI default output format | `json` |
| CLI profile name | `hiaws` |

### Default profile
Set in `~/dotfiles/zsh/.zshrc`:
```bash
export AWS_PROFILE=hiaws
```

### Daily refresh (every 8 hours)
```bash
aws sso login
```

### Verify session
```bash
aws sts get-caller-identity
```

### Sign out
```bash
aws sso logout
```

---

## Common Errors & Fixes

| Error | Fix |
|---|---|
| `Token has expired and refresh failed` | `aws sso login` |
| `Unable to locate credentials` | `echo $AWS_PROFILE` to confirm it's set |
| `An error occurred (AccessDenied)` | Check role permissions |
| `Rate exceeded` (console) | Wait 1–5 minutes |

---

## Recovery

### Lost YubiKey (have backup)
- Sign in with backup YubiKey
- Register replacement key
- Order and configure a new backup

### Lost both YubiKeys (root)
- Worst case — requires AWS Support and account verification (days)
- Prevention: store backup physically separate from primary

### Lost both YubiKeys (Identity Center user)
- Sign in to root with root YubiKey
- IAM Identity Center → Users → `hi1906` → reset MFA

---

## Where Things Live

| Item | Location |
|---|---|
| AWS CLI config | `~/.aws/config` |
| SSO cached tokens | `~/.aws/sso/cache/` |
| `AWS_PROFILE` env var | `~/dotfiles/zsh/.zshrc` |
| YubiKey storage | (your notes) |

---

## Security Posture

- Zero static access keys on disk or in account
- Hardware FIDO2 MFA (YubiKey) on root and daily user
- Federated identity via Identity Center
- Short-lived SSO sessions (8 hours, auto-refresh)
- Root isolated for break-glass only

### Future improvements
- Enable CloudTrail (multi-region, all events)
- Set up AWS Config
- Create scoped permission sets (least privilege)
- Set a $5 budget alert
- Add a third YubiKey stored off-site
