#!/usr/bin/python
import sys
import os
import time
import stashy # pip3 install stashy

serverName = ""
url = "https://{serverName}/bitbucket"
userName = ""
password = ""

stash = stashy.connect(url, userName, password)

def cloneAllProjectsAndAllRepos():
  allProjects = stash.projects.list()
  for proj in allProjects:
    cloneProjectRepos(proj['name'], proj['key'])


def cloneAllProjectsReposByManualList(listOfProjects):
  allProjects = stash.projects.list()
  for project in listOfProjects:
    for proj in allProjects:
      if proj['name'] == project:
        projKey = proj['key']
        break

    cloneProjectRepos(project, projKey)


def cloneProjectRepos(project, key):
  cloneReposToThisDir = f"/home/{userName}/code/git/Projects/{project}"
  if not os.path.exists(cloneReposToThisDir):
      os.mkdir(cloneReposToThisDir)
      time.sleep(3)

  os.chdir(cloneReposToThisDir)
  projRepos = stash.projects[key].repos.list()
  for repo in projRepos:
    for url in repo["links"]["clone"]:
        if (url["name"] == "ssh"):
            #print("git clone %s" % url["href"] + " into " + os.getcwd())
            os.system("git clone %s" % url["href"])
            break


if __name__ == '__main__':
  listOfProjectsNames = ['MyBitbucketProjectNAMENotKey']
  
  cloneAllProjectsReposByManualList(listOfProjectsNames)
  #cloneAllProjectsAndAllRepos()
