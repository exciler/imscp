#!/usr/bin/perl

# i-MSCP - internet Multi Server Control Panel
# Copyright (C) 2010-2013 by internet Multi Server Control Panel
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# @category		i-MSCP
# @copyright	2010-2013 by i-MSCP | http://i-mscp.net
# @author		Daniel Andreca <sci2tech@gmail.com>
# @link			http://i-mscp.net i-MSCP Home Site
# @license		http://www.gnu.org/licenses/gpl-2.0.html GPL v2

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/..";
use lib "$FindBin::Bin/../PerlLib";
use lib "$FindBin::Bin/../PerlVendor";

use iMSCP::Debug;
use iMSCP::Boot;
use iMSCP::Addons;

newDebug('imscp-set-gui-permissions.log');

sub start_up
{
	umask(027);

	iMSCP::Boot->new()->init({ 'nolock' => 'yes', 'nodatabase' => 'yes' });

	0;
}

sub shut_down
{
	my @warnings = getMessageByType('WARNING');
	my @errors = getMessageByType('ERROR');

	my $msg = "\nWARNINGS:\n" . join("\n", @warnings) . "\n" if @warnings > 0;
	$msg .= "\nERRORS:\n" . join("\n", @errors) . "\n" if @errors > 0;

	if($msg) {
		require iMSCP::Mail;
		iMSCP::Mail->new()->errmsg($msg);
	}

	0;
}

sub set_permissions
{
	my ($rs, $item, $file, $class);

	for('named', 'ftpd', 'mta', 'po', 'httpd') {
		$file = "Servers/$_.pm";
		$class = "Servers::$_";
		require $file;
		$item = $class->factory();

		if($item->can('setGuiPermissions')) {
			debug("Set GUI permissions for the $_ server");
			$rs |= $item->setGuiPermissions();
		}

		last if $rs;
	}

	if(! $rs) {
		for(iMSCP::Addons->new()->get()) {
			s/\.pm//;

			$file = "Addons/$_.pm";
			$class = "Addons::$_";
			require $file;
			$item = $class->factory();

			if( $item->can('setGuiPermissions')) {
				debug("Set GUI permissions for the $_ addon");
				$rs |= $item->setGuiPermissions();
			}

			last if $rs;
		}
	}

	$rs;
}

exit 1 if start_up();
exit 1 if set_permissions();
exit 1 if shut_down();
exit 0;
