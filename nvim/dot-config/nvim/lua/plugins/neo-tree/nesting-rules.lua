return {
	nesting_rules = {
		["js"] = {
			pattern = "^(.+)%.js$",
			files = { "%1.js.map", "%1.*.js", "%1.d.ts" },
		},
		[".gitignore"] = {
			pattern = "^%.gitignore$",
			files = { ".gitattributes", ".gitmodules", ".gitmessage", ".mailmap", ".git-blame*" },
		},
		["package.json"] = {
			pattern = "^package%.json$",
			files = {
				"package-lock.json",
				"yarn*",
				".browserslist*",
				".circleci*",
				".commitlint*",
				".cz-config.js",
				".czrc",
				".dlint.json",
				".dprint.json*",
				".editorconfig",
				".eslint*",
				".firebase*",
				".flowconfig",
				".github*",
				".gitlab*",
				".gitpod*",
				".huskyrc*",
				".jslint*",
				".lintstagedrc*",
				".markdownlint*",
				".node-version",
				".nodemon*",
				".npm*",
				".nvmrc",
				".pm2*",
				".pnp.*",
				".pnpm*",
				".prettier*",
				".release-please*.json",
				".releaserc*",
				".sentry*",
				".simple-git-hooks*",
				".stackblitz*",
				".styleci*",
				".stylelint*",
				".tazerc*",
				".textlint*",
				".tool-versions",
				".travis*",
				".versionrc*",
				".vscode*",
				".watchman*",
				".xo-config*",
				".yamllint*",
				".yarnrc*",
				"Procfile",
				"apollo.config.*",
				"appveyor*",
				"azure-pipelines*",
				"bower.json",
				"build.config.*",
				"bun.lockb",
				"commitlint*",
				"crowdin*",
				"dangerfile*",
				"dlint.json",
				"dprint.json*",
				"electron-builder.*",
				"eslint*",
				"firebase.json",
				"grunt*",
				"gulp*",
				"jenkins*",
				"lerna*",
				"lint-staged*",
				"nest-cli.*",
				"netlify*",
				"nodemon*",
				"npm-shrinkwrap.json",
				"nx.*",
				"package.nls*.json",
				"phpcs.xml",
				"pm2.*",
				"pnpm*",
				"prettier*",
				"pullapprove*",
				"pyrightconfig.json",
				"release-please*.json",
				"release-tasks.sh",
				"release.config.*",
				"renovate*",
				"rollup.config.*",
				"rspack*",
				"simple-git-hooks*",
				"stylelint*",
				"tslint*",
				"tsup.config.*",
				"turbo*",
				"typedoc*",
				"unlighthouse*",
				"vercel*",
				"vetur.config.*",
				"webpack*",
				"workspace.json",
				"xo.config.*",
			},
		},
		["readme"] = {
			pattern = "^readme.*",
			ignore_case = true,
			files = {
				"authors",
				"backers*",
				"changelog*",
				"citation*",
				"code_of_conduct*",
				"codeowners",
				"contributing*",
				"contributors",
				"copying*",
				"credits",
				"governance.md",
				"history.md",
				"license*",
				"maintainers",
				"readme*",
				"security.md",
				"sponsors*",
			},
		},
		["docker"] = {
			pattern = "^dockerfile$",
			ignore_case = true,
			files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
		},
		["composer.json"] = {
			pattern = "^composer%.json$",
			files = { ".php*.cache", "composer.lock", "phpunit.xml*", "psalm*.xml" },
		},
		[".env"] = {
			pattern = "^%.env$",
			files = { "*.env", ".env.*", ".envrc", "env.d.ts" },
		},
		["tex"] = {
			pattern = "^(.*)%.tex$",
			files = {
				"%1.acn",
				"%1.acr",
				"%1.alg",
				"%1.aux",
				"%1.bbl",
				"%1.blg",
				"%1.fdb_latexmk",
				"%1.fls",
				"%1.glg",
				"%1.glo",
				"%1.gls",
				"%1.idx",
				"%1.ind",
				"%1.ist",
				"%1.lof",
				"%1.log",
				"%1.lot",
				"%1.out",
				"%1.pdf",
				"%1.synctex.gz",
				"%1.toc",
				"%1.xdv",
			},
		},
		["jsx"] = {
			pattern = "^(.*)%.jsx$",
			files = { "%1.js", "%1.*.jsx", "%1_*.js", "%1_*.jsx", "%1.less", "%1.module.less" },
		},
		["ts"] = {
			pattern = "^(.*)%.ts$",
			files = { "%1.js", "%1.d.ts.map", "%1.*.ts", "%1_*.js", "%1_*.ts" },
		},
		["svg"] = {
			pattern = "^(.*)%.svg$",
			files = { "%1.svgz", "%1.svg.*" },
		},
		["css"] = {
			pattern = "^(.*)%.css$",
			files = { "%1.css.map", "%1.*.css" },
		},
		-- for testing
		["go"] = {
			pattern = "(.*)%.go$",
			files = { "%1_test.go" },
		},
	},
}
