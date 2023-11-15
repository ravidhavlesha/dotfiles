function awsecrpush --argument-names repository_name release_version --description "Push docker image to AWS ECR"
    set_color cyan

    if test "$repository_name" = "" || test "$release_version" = ""
        set_color red
        echo "Repository name and release version is required!" >&2 && return 1
    end

    set image_name $repository_name:$release_version

    set path (pwd)/containers/backend
    echo "Dockerfile path: $path"
    cd $path
    echo "Building docker image $image_name..."
    set_color normal
    set_color white
    docker build -t $image_name .

    echo "Login to AWS using MFA authentication..."
    awslogin

    set_color cyan
    echo "Getting AWS ECR repository uri and tagging image"
    set repository_uri (aws ecr describe-repositories \
        --repository-names $repository_name \
        --query repositories[0].repositoryUri | string replace -- "/$repository_name" ''
    )

    if test "$repository_uri" = ""
        set_color red
        echo "Not able to find your AWS ECR repository!" >&2 && return 1
    end

    docker tag $image_name $repository_uri/$image_name

    echo "Proceeding with AWS ECR login..."
    set_color green
    aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $repository_uri
    set_color cyan

    echo "Pushing docker image $image_name to $repository_uri"
    read -p 'echo "Confirm? (y/n):"' -l confirm

    switch $confirm
        case Y y
            echo "Pushing..."
            docker push $repository_uri/$image_name
        case '' N n
            echo "Push cancelled"
    end

    set_color green
    echo "Operation complete!"
end
