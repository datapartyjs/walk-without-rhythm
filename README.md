# walk-without-rhythm

<i>"And you won't attract the worm"</i>

Open Source Bash scripts which can detect signs of the Sha1-Hulud 2025-11-24 NPM/Github supply chain attack.

 * Support - [ko-fi/dataparty](https://ko-fi.com/dataparty)

### Requirements

 * bash
 * sed
 * grep
 * jq
 * curl


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

### `./is-npm-still-dangerous`

 * Reads the `data/infected-pkgs.txt`
 * Downloads the latest package metadata for every known infected package
 * Downloads the current latest package.tgz
 * Uncompresses and scans the latest version using `./check-projects`
 * Depending upon the scan result 

```bash
./is-npm-still-dangerous

capacitor-voice-recorder-wav 6.0.3 - STILL COMPROMISED
haufe-axera-api-client 0.0.2 - STILL COMPROMISED
hyper-fullfacing 1.0.3 - STILL COMPROMISED
@ifelsedeveloper/protocol-contracts-svm-idl 0.1.2 - STILL COMPROMISED
my-saeed-lib 0.1.1 - STILL COMPROMISED
quickswap-ads-list 1.0.33 - STILL COMPROMISED
@seung-ju/react-native-action-sheet 0.2.1 - STILL COMPROMISED
tcsp 2.0.2 - STILL COMPROMISED
web-types-lit 0.1.1 - STILL COMPROMISED
Found 9 npm-reports/npm-latest-bad.txt packages STILL compromised!

See npm-reports/npm-latest-bad.txt for full listing.
```


<i> Warning - Most people probably don't need to run this. It causes a lot of NPM traffic. </i>
<i> Warning - There's a few packages this fails to download and check (likely bc's they are hosted outside of NPMjs.org) </i>


## NodeJS Supply Chain Attack, What's Going On?

https://helixguard.ai/blog/malicious-sha1hulud-2025-11-24

There is an onging supply chain attack currently affect NPM and GitHub. The details of this cybersecurity incident and it's discover posted a blog security company HelixGuard linked above.

At the time our team read the blog post we were able to quickly verify the security incident as well as rapidly locate evidence of the ongoing nature of this attack. Live updates will be posted to the below mastodon thread. 

https://partyon.xyz/@nullagent/115607631833338864

## Is the worm still active?

As of Noon Pacific time on November 26th, 2025, yes the worm is still active. Infected packages hosted by NPM continue to spread(ie #16 for an example). Meanwhile github continues to be a landing point the worm is publicaly stolen data to. From what we can see the worm IS active but has slowed down significantly.

## Steps to take

- Turn on Multi-Factor Authentication (MFA / 2FA) immediately on your NPM & GitHub accounts (and all other key infra). Change and review passwords for cloud services you use.
- You probably shouldn't run any `npm install` or `npm update` commands until NPM and GitHub have official mitigations in place.
- Before doing anything else you probably should check for signs of comproise. This can be done manually or using this repo or other similar scanning tools. If you DO continue working from an infected machine you risk having your personal data stolen or destroyed by this worm.
- After verifying that your system has not already been compromised you can likely safely work as normal but you should avoid upgrading or installing any different package versions. Its not fully clear at the time of posting if NPM is taking down infected packages we're still finding infected packages for download on NPM at this time.
- Before installing a new version of a package, you can download a `.tgz` archive using the command `npm pack <package-name>`. This does not install the package. You can then uncompress the package and check it for signs of compromise.
- Consider disabling install scripts
  - `npm install --ignore-scripts` - Ignore install scripts
  - `npm config set ignore-scripts true` - Ignore install scripts user wide
  - [<i>"Package install scripts vulnerability"</i>](https://blog.npmjs.org/post/141702881055/package-install-scripts-vulnerability) - NPM blog post from 2016 explaining worm mitigations
- Consider using a tool for fine grained script management
  - [`@lavamoat/allow-scripts`](https://www.npmjs.com/package/@lavamoat/allow-scripts)
  - [`can-i-ignore-scripts`](https://www.npmjs.com/package/can-i-ignore-scripts)
- If you are a package maintainer consider using `npm shrinkwrap`
  - [Documentation](https://docs.npmjs.com/cli/v11/commands/npm-shrinkwrap)
  - [`package-lock.json` vs `npm-shrinkwrap.json`](https://docs.npmjs.com/cli/v11/configuring-npm/package-lock-json#package-lockjson-vs-npm-shrinkwrapjson)


# Similar Sha1-Hulud 11/24/25 Detection Tools

<i> Links to other projects provided with no warranty express or implied. </i>

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



# Further Reading

* https://about.gitlab.com/blog/gitlab-discovers-widespread-npm-supply-chain-attack/

* https://www.sysdig.com/blog/return-of-the-shai-hulud-worm-affects-over-25-000-github-repositories

* https://www.koi.ai/incident/live-updates-sha1-hulud-the-second-coming-hundred-npm-packages-compromised#heading-4

