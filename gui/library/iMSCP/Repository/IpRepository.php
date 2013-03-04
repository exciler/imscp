<?php
namespace iMSCP\Repository;

use iMSCP\Entity\Domain;
use iMSCP\Entity\Ip;

/**
 * @author Andreas Palm <andi@andipalm.de>
 *
 */
class IpRepository
{
    /**
     * @return Ip[]
     */
    public function findAll()
    {
        $query = "SELECT ip_id, ip_number, ip_domain, ip_alias, ip_card, ip_status, ip_shared FROM server_ips";
        $stmt = exec_query($query);
        $objects = array();
        if ($stmt->rowCount())
            while (!$stmt->EOF) {
                $objects[] = \iMSCP\Entity\Ip::FromArray($stmt->fields);
                $stmt->moveNext();
            }
        return $objects;
    }

    public function findByDomain(Domain $domain)
    {
        $query = "SELECT si.ip_id, si.ip_number, si.ip_domain, si.ip_alias, si.ip_card, si.ip_status, si.ip_shared
                  FROM server_ips si, ip_domain_assignment ida
                  WHERE si.ip_id=ida.ip_id
                  AND ida.domain_id = ?";
        $stmt = exec_query($query);
        $objects = array();
        if ($stmt->rowCount())
            while (!$stmt->EOF) {
                $objects[] = \iMSCP\Entity\Ip::FromArray($stmt->fields);
                $stmt->moveNext();
            }
        return $objects;
    }
}
