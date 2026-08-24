# homebrew-tap

Personal Homebrew tap for [drayanaindra](https://github.com/drayanaindra)'s tools.

## saki

Runs `saki-backend` — the backend for [saki-cli](https://github.com/drayanaindra/saki-cli) — as a
persistent background service (launchd on macOS, systemd on Linux), instead of the `saki` CLI's
lazy per-command auto-start. Useful if something other than the `saki` CLI needs to reach the
backend independently.

```bash
brew tap drayanaindra/tap
brew trust --tap drayanaindra/tap   # non-official tap — Homebrew asks you to confirm this once
brew install saki
brew services start saki
```

Verify it's up:

```bash
curl -s http://127.0.0.1:8788/api/health
# {"ok":true,"service":"saki-backend"}
```

Stop it:

```bash
brew services stop saki
```

### Coexisting with the `saki` CLI

If you've already used the `saki` CLI directly (which lazily spawns its own backend), run
`saki backend stop` first — `saki-backend` binds `127.0.0.1:8788` exclusively and exits immediately
if the port's already held, so a lazily-spawned instance and this service can't both own it. Once
the service owns the port, `saki` CLI commands reuse it automatically.

`saki-backend` writes its own state file on every startup (keyed on your user + temp dir), so
`saki backend stop` can stop this service's process too if it finds it — `brew services`'
`keep_alive` self-heals it (restarts automatically), but you'll briefly see it as stopped. Use
`brew services stop saki` if you want it to actually stay down.

### Uninstall

```bash
brew services stop saki
brew uninstall saki
brew untap drayanaindra/tap
```

## Updating

The formula tracks [saki-cli releases](https://github.com/drayanaindra/saki-cli/releases). See
[`docs/RELEASING.md`](https://github.com/drayanaindra/saki-cli/blob/main/docs/RELEASING.md) in that
repo for the release procedure this tap's version bump is part of.

```bash
brew update
brew upgrade saki
brew services restart saki   # required — reinstall/upgrade swaps the binary, the running
                              # process (if you use `brew services`) keeps the old one in memory
```

Verify the running process actually picked up the new binary:

```bash
brew services list | grep saki      # confirm it's "started", not "error"
curl -s http://127.0.0.1:8788/api/health
```
