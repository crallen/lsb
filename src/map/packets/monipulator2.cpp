﻿/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "monipulator2.h"

#include "common/socket.h"
#include "entities/charentity.h"
#include "monstrosity.h"

CMonipulatorPacket2::CMonipulatorPacket2(CCharEntity* PChar)
{
    this->setType(0x63);
    this->setSize(0xB4);

    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    std::memset(data + 4, 0, PACKET_SIZE - 4);

    // TODO: What are these?
    std::array<uint8, 3> packet2 = { 0x04, 0x00, 0xB0 };
    std::memcpy(data + (0x04), &packet2, sizeof(packet2));

    // NOTE: SE added these after-the-fact, so they're not sent in Monipulator1 and they're at the end of the array!
    // Slime Level
    ref<uint8>(0x86) = PChar->m_PMonstrosity->levels[126];

    // Spriggan Level
    ref<uint8>(0x87) = PChar->m_PMonstrosity->levels[127];

    // Bitpacked 2-bit values. 0 = no instincts from that species, 1 == first instinct, 2 == first and second instinct, 3 == first, second, and third instinct.
    // Contains job/race instincts from the 0x03 set. Has 8 unused bytes. This is a 1:1 mapping.
    // TODO: Hook up to use latter parts of instincts array
    // std::memcpy(data + 0x88, PChar->m_PMonstrosity->instincts.data(), 12); // Instinct Bitfield 3

    // Does not show normal monsters, only variants. Bit is 1 if the variant is owned. Length is an estimation including the possible padding.
    std::memcpy(data + 0x94, PChar->m_PMonstrosity->variants.data(), 32); // Variants Bitfield
}
