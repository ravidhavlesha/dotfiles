function awslogin --description "Login to AWS using MFA authentication"
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN

    set username (aws sts get-caller-identity \
        --output text \
        --query Arn | string replace --regex -- 'arn:aws:iam::.*:user/' ''
    )

    if test "$username" = ""
        set_color red
        echo "Not able to find your AWS account!" >&2 && return 1
    end

    set_color magenta
    echo "Hey $username,"
    set_color white

    set serial_number (aws iam list-mfa-devices \
        --user-name "$username" \
        --output text \
        --query MFADevices[0].SerialNumber
    )

    set_color cyan
    echo "Please enter your MFA token(6 digit):"
    read -l mfa_token

    set aws_cli (aws sts get-session-token \
        --serial-number="$serial_number" \
        --token-code=$mfa_token \
        --output text \
        --query 'Credentials | join (`;`,values({ AccessKeyId: join(``, [`set -Ux AWS_ACCESS_KEY_ID `,AccessKeyId]), SecretAccessKey:join(``, [`set -Ux AWS_SECRET_ACCESS_KEY `,SecretAccessKey]), SessionToken:join(``, [`set -Ux AWS_SESSION_TOKEN `,SessionToken]), Expiration:join(``, [`set -Ux AWS_SESSION_EXPIRY `,Expiration]) }))' \
    )

    if fish -c $aws_cli
        set_color green
        export AWS_DEFAULT_REGION=us-east-1
        echo "AWS login successful!"
        echo "Session token valid until $AWS_SESSION_EXPIRY"
    else
        set_color red
        echo "Error occured while fetching session token!" >&2 && return 1
    end
end
