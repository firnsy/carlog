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
package CarLog::Store::Trip;

use strict;
use base 'CarLog::Store';

__PACKAGE__->table('carlog_trip');
__PACKAGE__->columns(All => qw/id vehicle_id odo_start dtg_start odo_end dtg_end description business/);

__PACKAGE__->has_a(vehicle_id => 'CarLog::Store::Vehicle');

#
# inflate/deflate epoch stored values
__PACKAGE__->has_a(
  dtg_start => 'Time::Piece',
  inflate   => sub { Time::Piece->strptime( shift, "%Y-%m-%d %H:%M:%S" ) },
  deflate   => sub { shift->strftime("%Y-%m-%d %H:%M:%S") }
);

__PACKAGE__->has_a(
  dtg_end   => 'Time::Piece',
  inflate   => sub { Time::Piece->strptime( shift, "%Y-%m-%d %H:%M:%S" ) },
  deflate   => sub { shift->strftime("%Y-%m-%d %H:%M:%S") }
);

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

__PACKAGE__->set_sql(unfinished => qq {
SELECT *
  FROM carlog_trip
  WHERE ( carlog_trip.odo_end IS NULL )
});

1;
