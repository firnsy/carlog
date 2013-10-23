#
# Copyright (C) 2013    Ian Firns   <firnsy@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
package CarLog::Store::Vehicle;

use strict;
use base 'CarLog::Store';

__PACKAGE__->table('carlog_vehicle');
__PACKAGE__->columns(All => qw/id user_id description registration created updated/);

__PACKAGE__->has_a(user_id   => 'CarLog::Store::User');
__PACKAGE__->has_many(trips  => 'CarLog::Store::Trip'  => 'vehicle_id');

# default value for created
__PACKAGE__->set_sql(MakeNewObj => qq{
INSERT INTO __TABLE__ (created, updated, %s)
VALUES (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, %s)
});

__PACKAGE__->set_sql(update => qq {
UPDATE __TABLE__
  SET    updated = CURRENT_TIMESTAMP, %s
  WHERE  __IDENTIFIER__
});

__PACKAGE__->set_sql(update => qq {
UPDATE __TABLE__
  SET    updated = CURRENT_TIMESTAMP, %s
  WHERE  __IDENTIFIER__
});

__PACKAGE__->set_sql(unfinished => qq {
SELECT carlog_vehicle.*
  FROM carlog_vehicle
  JOIN carlog_trip
    ON (carlog_trip.vehicle_id=carlog_vehicle.id) 
  WHERE ( ( carlog_trip.odo_end IS NULL ) AND ( carlog_vehicle.id=? ) )
});


sub trip_active() {
  my $c = shift;

  my @unfinished = $c->search_unfinished( $c->id );

  return @unfinished > 0;
}

1;
