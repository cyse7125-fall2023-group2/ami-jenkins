pipelineJob('webapp') {
    description('My Pipeline Job Description')
    definition {
        cpsScm {
            scriptPath('Jenkinsfile') // Reference the Jenkinsfile in your SCM
            scm {
                git {
                    remote {
                        url('https://github.com/cyse7125-fall2023-group2/webapp.git')
                        credentials('GITHUB_CREDENTIALS_ID') // Specify your GitHub credentials ID
                    }
                    branch('main') // Specify the branch you want to build
                }
            }
        }
    }
    triggers {
        githubPush() // Trigger the job on a GitHub push event
    }
}
pipelineJob('webapp-Helm') {
    description('My Pipeline Job Description')
    definition {
        cpsScm {
            scriptPath('Jenkinsfile') // Reference the Jenkinsfile in your SCM
            scm {
                git {
                    remote {
                        url('https://github.com/cyse7125-fall2023-group2/webapp-helm-chart.git')
                        credentials('GITHUB_CREDENTIALS_ID') // Specify your GitHub credentials ID
                    }
                    branch('main') // Specify the branch you want to build
                }
            }
        }
    }
    triggers {
        githubPush() // Trigger the job on a GitHub push event
    }
}
pipelineJob('webapp-operator') {
    description('My Pipeline Job Description')
    definition {
        cpsScm {
            scriptPath('Jenkinsfile') // Reference the Jenkinsfile in your SCM
            scm {
                git {
                    remote {
                        url('https://github.com/cyse7125-fall2023-group2/webapp-operator.git')
                        credentials('GITHUB_CREDENTIALS_ID') // Specify your GitHub credentials ID
                    }
                    branch('main') // Specify the branch you want to build
                }
            }
        }
    }
    triggers {
        githubPush() // Trigger the job on a GitHub push event
    }
}