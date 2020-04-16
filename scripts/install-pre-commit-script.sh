echo 'installing pre-commit script...'
ln -sfn ./pre-commit.sh ../.git/hooks/pre-commit 
chmod +x ../.git/hooks/pre-commit