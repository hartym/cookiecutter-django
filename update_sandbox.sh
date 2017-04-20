#! /bin/bash

__PATH__=$(cd $(dirname "$0"); pwd)
SANDBOX_PATH=sandbox
SANDBOX_PATH2=sandbox2
REPOSITORY=git@gitlab.com:rdorgueil/django-sandbox.git

if [ ! -d "$SANDBOX_PATH" ]; then
  git clone $REPOSITORY $SANDBOX_PATH
else
  (cd $SANDBOX_PATH; git pull origin master)
fi

mkdir $SANDBOX_PATH2
mv $SANDBOX_PATH/.git $SANDBOX_PATH2
rm -rf $SANDBOX_PATH
mv $SANDBOX_PATH2 $SANDBOX_PATH

cookiecutter . --no-input --overwrite-if-exists project_name=Sandbox description='A django sandbox' use_celery=y docker_namespace=registry.gitlab.com/rdorgueil

(cp -a addons/sandbox/. $SANDBOX_PATH)
(cd $SANDBOX_PATH; git add .; git ci -m "auto update with generated code."; git push origin master)



