# walk-without-rhythm

<i>"And you won't attract the worm"</i>

Bash scripts which can detect signs of the sha1hulud-2025-11-24 NPM/Github supply chain attack.

### Requirements

 * bash
 * sed
 * grep
 * jq

## How to use

This is extremely expiremental so there's likely false postivies. If the attacker adapts this repo may produce false negatives. Besure to read the issues and report bugs.


### `./check-projects <path-to-projects>`

```bash
./check-projects <path-to-projects>
```

First pass is super simple and just looks for the file names & package.json signature for signs of infection. If the first pass finds something sketchy it stops and repors where:


<img width="689" height="277" alt="Screenshot From 2025-11-24 23-39-35" src="https://github.com/user-attachments/assets/e4a6b3ae-af36-42b7-8c5a-bd7abf27b323" />

It also compiles a full listing of all direct dev & production nodejs dependencies by name and name+version. If any version of a package that was known to have published an infected build to NPM is referenced anywhere in your dependency graph an alert will also be shown.


Files continue state are located in the `reports/` and `reports/state` directories. These files maybe useful for additional scanning solutions.

<img width="681" height="453" alt="Screenshot From 2025-11-24 23-41-47" src="https://github.com/user-attachments/assets/45cf38bd-78f6-4fc1-9839-73eb9b678e52" />




## NodeJS Supply Chain Attack, What's Going On?

https://helixguard.ai/blog/malicious-sha1hulud-2025-11-24

There is an onging supply chain attack currently affect NPM and GitHub. The details of this cybersecurity incident and it's discover posted a blog security company HelixGuard linked above.

At the time our team read the blog post we were able to quickly verify the security incident as well as rapidly locate evidence of the ongoing nature of this attack. Live updates will be posted to the below mastodon thread. 

https://partyon.xyz/@nullagent/115607631833338864

## Steps to take

1. You probably shouldn't run any `npm install` or `npm update` commands until NPM and GitHub have official mitigations in place.
2. Before doing anything else you probably should check for signs of comproise. This can be done manually or using this repo or other similar scanning tools. If you DO continue working from an infected machine you risk having your personal data stolen or destroyed by this worm.
3. After verifying that your system has not already been compromised you can likely safely work as normal but you should avoid upgrading or installing any different package versions. Its not fully clear at the time of posting if NPM is taking down infected packages we're still finding infected packages for download on NPM at this time.
4. Before installing a new version of a package, you can download a `.tgz` archive using the command `npm pack <package-name>`. This does not install the package. You can then uncompress the package and check it for signs of compromise.

