import type { UserConfig } from '@commitlint/types';
import { RuleConfigSeverity } from '@commitlint/types';

const Configuration: UserConfig = {
  rules: {
    'type-empty': [RuleConfigSeverity.Error, 'never'],
    'type-case': [RuleConfigSeverity.Error, 'always', 'lower-case'],
    'type-enum': [
      RuleConfigSeverity.Error,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'ui',
        'style',
        'refactor',
        'perf',
        'test',
        'build',
        'chore',
        'revert',
        'release',
      ],
    ],
    'scope-empty': [RuleConfigSeverity.Error, 'never'],
    'scope-case': [RuleConfigSeverity.Error, 'always', 'lower-case'],
    'scope-enum': [
      RuleConfigSeverity.Error,
      'always',
      [
        'mobile',
        'api',
        'website',
        'ci',
        'deps',
        'config',
        'test'
      ],
    ],
    'subject-empty': [RuleConfigSeverity.Error, 'never'],
    'subject-case': [RuleConfigSeverity.Error, 'always', 'lower-case'],
    'header-max-length': [RuleConfigSeverity.Error, 'always', 72],
    'body-leading-blank': [RuleConfigSeverity.Warning, 'always'],
    'footer-leading-blank': [RuleConfigSeverity.Warning, 'always'],
  },
};

export default Configuration;
