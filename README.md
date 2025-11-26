# walk-without-rhythm

<i>"And you won't attract the worm"</i>

Open Source Bash scripts which can detect signs of the Sha1-Hulud 2025-11-24 NPM/Github supply chain attack.

 * Support - [ko-fi/dataparty](https://ko-fi.com/dataparty)

## How to use

This is extremely expiremental so there's likely false postivies. If the attacker adapts this repo may produce false negatives. Besure to read the issues and report bugs.


### `./check-projects <path-to-projects>`

```bash
./check-projects <path-to-projects>
```

 * Check `package.json` recursively for references to `setup_bun.js`
 * Crawl all `package.json` && `package-lock.json` for a complete listing of package names and versions
 * Check the full listing of package names against the list of known infected NPM packages.
   * If any of the `package.json`  or `package-lock.json` reference any of these known infected packages at ANY version a warning and full listing will be printed.
   * See https://github.com/datapartyjs/walk-without-rhythm/blob/main/data/infected-pkgs-versions.txt
 * Sets Exit Codes
   * `0` - Clean, no issues found
   * `1` - Warnings found (verification needed)
   * `2` - Critical issues found (immediate action required)
   * `3` - Error during scan
   * Compatible with the exit codes used in [other scanners](https://github.com/TimothyMeadows/sha1hulud-scanner?tab=readme-ov-file#exit-codes)

#### Example - Infected Project & Dependency

<img width="689" height="277" alt="Screenshot From 2025-11-24 23-39-35" src="https://github.com/user-attachments/assets/e4a6b3ae-af36-42b7-8c5a-bd7abf27b323" />

##### Example - Reports and State

Reports and state are saved to `reports/` and `reports/state` directories. These files maybe useful for additional scanning solutions. 

The tool clears state between runs. Report files are not deleted and in most cases are merged between runs so multiple runs provide the combined results.

<img width="681" height="453" alt="Screenshot From 2025-11-24 23-41-47" src="https://github.com/user-attachments/assets/45cf38bd-78f6-4fc1-9839-73eb9b678e52" />


### Requirements

 * bash
 * sed
 * grep
 * jq
 * curl

## NodeJS Supply Chain Attack, What's Going On?

https://helixguard.ai/blog/malicious-sha1hulud-2025-11-24

There is an onging supply chain attack currently affect NPM and GitHub. The details of this cybersecurity incident and it's discover posted a blog security company HelixGuard linked above.

At the time our team read the blog post we were able to quickly verify the security incident as well as rapidly locate evidence of the ongoing nature of this attack. Live updates will be posted to the below mastodon thread. 

https://partyon.xyz/@nullagent/115607631833338864

## Steps to take

0. Turn on Multi-Factor Authentication (MFA / 2FA) immediately on your NPM & GitHub accounts (and all other key infra). Change and review passwords for cloud services you use.
1. You probably shouldn't run any `npm install` or `npm update` commands until NPM and GitHub have official mitigations in place.
2. Before doing anything else you probably should check for signs of comproise. This can be done manually or using this repo or other similar scanning tools. If you DO continue working from an infected machine you risk having your personal data stolen or destroyed by this worm.
3. After verifying that your system has not already been compromised you can likely safely work as normal but you should avoid upgrading or installing any different package versions. Its not fully clear at the time of posting if NPM is taking down infected packages we're still finding infected packages for download on NPM at this time.
4. Before installing a new version of a package, you can download a `.tgz` archive using the command `npm pack <package-name>`. This does not install the package. You can then uncompress the package and check it for signs of compromise.

# Similar Tools

* https://github.com/TimothyMeadows/sha1hulud-scanner
* https://github.com/mottibec/sha1hulud-scanner
* https://github.com/gensecaihq/Shai-Hulud-2.0-Detector
* https://github.com/tprinty/sha1hulud-action-detector
* https://github.com/da1z/amihulud
* https://github.com/bobberg/sha1-hulud-folder-checker
* https://github.com/servusdei2018/sha1-halud-scan
* https://github.com/kevcooper/fremkit
* https://github.com/ysskrishna/shai-hulud-detector
* https://github.com/Cobenian/shai-hulud-detect

## GitHub Scanners

* https://github.com/ysskrishna/shai-hulud-detector
* https://github.com/panther-labs/panther-analysis/pull/1826


<i> Links to other projects provided with no warranty express or implied. </i>

# Further Reading

* https://about.gitlab.com/blog/gitlab-discovers-widespread-npm-supply-chain-attack/

* https://www.sysdig.com/blog/return-of-the-shai-hulud-worm-affects-over-25-000-github-repositories

* https://www.koi.ai/incident/live-updates-sha1-hulud-the-second-coming-hundred-npm-packages-compromised#heading-4

