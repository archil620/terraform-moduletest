// Get AWS Account Number
data "aws_caller_identity" "current" {}

// Get Account Region
data "aws_region" "current" {}



resource "aws_iam_instance_profile" "this" {
  name = "${var.instance_name}"
  role = "${aws_iam_role.default.name}"
}

resource "aws_iam_role" "default" {
  name               = "${var.role_name}"
  path               = "${var.role_path}"                                #Should we define this??
  description        = "${var.role_description}"
  assume_role_policy = "${data.aws_iam_policy_document.default.json}"
  tags               = "${var.app_role_tags}"
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "${var.identifier_type}"
      identifiers = "${"ec2.amazonaws.com"}"
    }
  }
}

data "aws_iam_policy_document" "default1" {
  statement {
    
    effect    = "Allow"
    resources = [
      "arn:aws:s3:::",
                "arn:aws:s3:::${var.bucketname}/*",
                "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${var.kmskey}"
    ]
    actions = [
       "s3:ListObject",
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:GenerateDataKey"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values = [
        "198.96.178.33/32",
        "198.96.180.245/32"
      ],

        test     = "StringEquals"
      variable = "aws:sourceVpce"
      values = ["${var.sourcevpcendpoint}"],

    test     = "StringEquals"
      variable = "aws:sourceVpc"
      values = ["${var.vpcid}"]

    }
  }
}

resource "aws_iam_role_policy" "default" {
  name   = "EC2 DegaultPolicy"
  role   = "${var.role_name}"
  policy = "${data.aws_iam_policy_document.default1.json}"
}
# resource "aws_iam_role_policy_attachment" "this" {
#   count      = "${length(var.policy_arn)}"
#   role       = "${aws_iam_role.this.name}"
#   policy_arn = "${var.policy_arn[count.index]}"
# }
