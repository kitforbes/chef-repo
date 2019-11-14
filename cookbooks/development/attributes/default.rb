default['git']['config']['email'] = 'git@chrisforbes.dev'
default['git']['config']['name'] = 'Chris Forbes'
default['git']['username'] = 'kitforbes'
default['git']['timeout'] = 1200
default['git']['servers'] = [
  {
    host: 'github.com',
    organisation: 'kitforbes',
    identityFile: '~/.ssh/github',
    repositories: [
      '1PasswordPS',
      'automaton',
      'bootstrap',
      'chef-repo',
      'Crawler',
      'docs',
      'environments',
      'guide',
      'handmade',
      'infrastructure',
      'jfa',
      'jfa-assets',
      'kitforbes.github.io',
      'qa-mvc',
      'SalaryComparer',
      'scripts',
      'TerraFirma',
      'trap',
      'unite',
      'university',
      'UtilitiesPS',
    ],
  },
  {
    host: 'gitlab.com',
    organisation: 'kitforbes',
    identityFile: '~/.ssh/id_rsa',
    repositories: [
    ],
  },
  {
    host: 'bitbucket.org',
    organisation: 'kitforbes',
    identityFile: '~/.ssh/id_rsa',
    repositories: [
    ],
  },
]

default['vscode']['extensions'] = [
  'bbenoist.vagrant',
  'burtlo.inspec',
  'codezombiech.gitignore',
  'DotJoshJohnson.xml',
  'EditorConfig.EditorConfig',
  'hashhar.gitattributes',
  'jirkafajfr.vscode-kitchen',
  'mauve.terraform',
  'ms-python.python',
  'ms-vscode.cpptools',
  'ms-vscode.csharp',
  'ms-vscode.PowerShell',
  'Pendrica.chef',
  'PeterJausovec.vscode-docker',
  'vscoss.vscode-ansible',
  'waderyan.gitblame',
  'wholroyd.jinja',
]
