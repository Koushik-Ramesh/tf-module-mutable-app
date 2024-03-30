local {
    INSTANCE_IDS    = concat(aws_instance.OD.*.id , aws_spot_instance_request.spot.*.spot_instance_id)
    INSTANCE_COUNT  = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
}
