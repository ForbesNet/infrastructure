variable "pihole_url" {
    description = "URL of pihole server"
    type = string
    default = "http://pi.hole"
}

variable "pihole_admin_pass" {
    description = "pihole admin pass...duh"
    type = string
    default = ""
}

variable "pihole_dns_records" {
    type = map(object({
        #dns_record = string
        ip = string
    }))
}