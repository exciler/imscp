<?php
namespace iMSCP\Entity;

use iMSCP_Database;

/**
 * @author Andreas Palm
 *
 * @property int $Id
 * @property string $Address
 * @property string $DomainName
 * @property string $Alias
 * @property string $NetworkCard
 * @property string $Status
 * @property bool $Shared
 */
class Ip
{
    protected $Id;

    protected $Address;

    protected $DomainName;

    protected $Alias;

    protected $NetworkCard;

    protected $Status;

    protected $Shared;

    function __get($name)
    {
        if (isset($this->$name))
            return $this->$name;
        throw new \Exception("Invalid property");
    }

    function __set($name, $value)
    {
        if (isset($this->$name))
            $this->$name = $value;
        else
            throw new \Exception("Invalid property");
    }

    public static function FromArray($data)
    {
        $Ip = new Ip();
        $Ip->Id = $data['ip_id'];
        $Ip->Address = $data['ip_number'];
        $Ip->DomainName = $data['ip_domain'];
        $Ip->Alias = $data['ip_alias'];
        $Ip->NetworkCard = $data['ip_card'];
        $Ip->Status = $data['ip_status'];
        $Ip->Shared = $data['ip_shared'];
        return $Ip;
    }

    public function insert()
    {
        /** @var $cfg iMSCP_Config_Handler_File */
        $cfg = iMSCP_Registry::get('config');
        $this->Status = $cfg->ITEM_ADD_STATUS;
        /** @var $db iMSCP_Database */
        $db = iMSCP_Registry::get('db');
        $query = "INSERT INTO server_ips (ip_number, ip_domain, ip_alias, ip_card, ip_status, ip_shared)
                  VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $db->execute($query, array($this->Address, $this->DomainName, $this->Alias, $this->NetworkCard, $this->Status, $this->Shared));
        $this->Id = $db->insertId();
    }

    public function delete()
    {
        /** @var $db iMSCP_Database */
        $db = iMSCP_Registry::get('db');
        $query = "DELETE FROM server_ips WHERE ip_id = ?";
        $stmt = $db->execute($query, $this->Id);
    }
}
