using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class Collapse : ObjectDefinition
	{
		private Sprite[][] img;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/platform.nem", CompressionType.Nemesis);

			img = new Sprite[2][];
			img[0] = new Sprite[2];
			img[1] = new Sprite[6];

			if (LevelData.Level.TimeZone != SonicRetro.SonLVL.API.TimeZone.Past || LevelData.Level.Act != 0)
			{
				img[0][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_ledge.asm", 0, 2);
				img[0][1] = ObjectHelper.UnknownObject;
			}
			else
			{
				img[0][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_ledge_1b.asm", 0, 2);
				img[0][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_ledge_1b.asm", 1, 2);
			}

			if (LevelData.Level.Act == 0)
			{
				switch (LevelData.Level.TimeZone)
				{
					case SonicRetro.SonLVL.API.TimeZone.Present:
						img[1][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 0, 2);
						img[1][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 1, 2);
						img[1][2] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 2, 2);
						img[1][3] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 3, 2);
						img[1][4] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 4, 2);
						img[1][5] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 5, 2);
						break;

					case SonicRetro.SonLVL.API.TimeZone.Past:
						img[1][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 0, 2);
						img[1][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 1, 2);
						img[1][2] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 2, 2);
						img[1][3] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 3, 2);
						img[1][4] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 4, 2);
						img[1][5] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 5, 2);
						break;

					case SonicRetro.SonLVL.API.TimeZone.Future:
						img[1][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1cd.asm", 0, 2);
						img[1][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1cd.asm", 1, 2);
						img[1][2] = ObjectHelper.UnknownObject;
						img[1][3] = ObjectHelper.UnknownObject;
						img[1][4] = ObjectHelper.UnknownObject;
						img[1][5] = ObjectHelper.UnknownObject;
						break;
				}
			}
			else
			{
				img[1][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_2.asm", 0, 2);
				img[1][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_2.asm", 1, 2);
				img[1][2] = ObjectHelper.UnknownObject;
				img[1][3] = ObjectHelper.UnknownObject;
				img[1][4] = ObjectHelper.UnknownObject;
				img[1][5] = ObjectHelper.UnknownObject;
			}
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return "Collapsing Ledge/Floor"; }
		}

		public override bool RememberState
		{
			get { return true; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
		}

		public override Sprite Image
		{
			get { return img[0][0]; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			int index = (subtype < 0x80) ? 0 : 1;
			subtype &= 0xF;
			if (subtype < img[index].Length)
				return img[index][subtype];
			return ObjectHelper.UnknownObject;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return SubtypeImage(obj.SubType);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Type", typeof(int), "Extended", "The type of ledge/floor", null, new Dictionary<string, int>
				{
					{ "Ledge 1", 0 },
					{ "Ledge 2", 1 },
					{ "Floor 1", 0x80 },
					{ "Floor 2", 0x81 },
					{ "Floor 3", 0x82 },
					{ "Floor 4", 0x83 },
					{ "Floor 5", 0x84 },
					{ "Floor 6", 0x85 },
				},
				(obj) => { return obj.SubType & 0x8F; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x8F) | ((int)value & 0x8F))),

			new PropertySpec("X Flip (Actual)", typeof(bool), "Extended", "Flips the object horizontally (use this instead of \"X Flip\").", null,
				(obj) => { return (obj.SubType & 0x10) == 0x10; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x10) | ((bool)value ? 0x10 : 0))),
				
			new PropertySpec("Reverse Collapse", typeof(bool), "Extended", "If true, the collapse direction is reversed (floors only).", null,
				(obj) => { return (obj.SubType & 0x20) == 0x20; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x20) | ((bool)value ? 0x20 : 0))),
				
			new PropertySpec("Check Player", typeof(bool), "Extended", "If true, the collapse direction is determined by the player's X speed (floors only).", null,
				(obj) => { return (obj.SubType & 0x40) == 0x40; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x40) | ((bool)value ? 0x40 : 0)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
