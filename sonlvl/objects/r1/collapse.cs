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

			img = new Sprite[6][];

			// Ledge (R11A, R11C, R11D, R12)
			img[0] = new Sprite[1];
			img[0][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_ledge.asm", 0, 2);

			// Ledge (R11B)
			img[1] = new Sprite[2];
			img[1][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_ledge_1b.asm", 0, 2);
			img[1][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_ledge_1b.asm", 1, 2);

			// Floor (R11A)
			img[2] = new Sprite[6];
			img[2][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 0, 2);
			img[2][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 1, 2);
			img[2][2] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 2, 2);
			img[2][3] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 3, 2);
			img[2][4] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 4, 2);
			img[2][5] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1a.asm", 5, 2);

			// Floor (R11B)
			img[3] = new Sprite[6];
			img[3][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 0, 2);
			img[3][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 1, 2);
			img[3][2] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 2, 2);
			img[3][3] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 3, 2);
			img[3][4] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 4, 2);
			img[3][5] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1b.asm", 5, 2);

			// Floor (R11C, R11D)
			img[4] = new Sprite[2];
			img[4][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1cd.asm", 0, 2);
			img[4][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_1cd.asm", 1, 2);

			// Floor (R12)
			img[5] = new Sprite[2];
			img[5][0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_2.asm", 0, 2);
			img[5][1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/collapse_floor_2.asm", 1, 2);
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

		private Sprite SetupSprite(byte subtype, bool x_flip, bool y_flip)
		{
			int index = 0;

			if (subtype < 0x80)
			{
				if (LevelData.Level.Act == 0 && LevelData.Level.TimeZone == SonicRetro.SonLVL.API.TimeZone.Past)
					index = 1;
				else
					index = 0;
			}
			else
			{
				if (LevelData.Level.Act == 0)
				{
					switch (LevelData.Level.TimeZone)
					{
						case SonicRetro.SonLVL.API.TimeZone.Present:
							index = 2;
							break;

						case SonicRetro.SonLVL.API.TimeZone.Past:
							index = 3;
							break;

						case SonicRetro.SonLVL.API.TimeZone.Future:
							index = 4;
							break;
					}
				}
				else
					index = 5;
			}
				
			if ((subtype & 0x0F) >= img[index].Length)
				return ObjectHelper.UnknownObject;
			return new Sprite(img[index][subtype & 0x0F], ((subtype & 0x10) != 0) || x_flip, y_flip);
		}

		public override Sprite Image
		{
			get { return SetupSprite(0, false, false); }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return SetupSprite(subtype, false, false);
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return SetupSprite(obj.SubType, obj.XFlip, obj.YFlip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Type", typeof(int), "Extended", "The type of ledge/floor", null, new Dictionary<string, int>
				{
					{ "Ledge 1", 0x00 },
					{ "Ledge 2", 0x01 },
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
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x10) | ((bool)value ? 0x10 : 0x00))),
				
			new PropertySpec("Reverse Collapse", typeof(bool), "Extended", "If true, the collapse direction is reversed (floors only).", null,
				(obj) => { return (obj.SubType & 0x20) == 0x20; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x20) | ((bool)value ? 0x20 : 0x00))),
				
			new PropertySpec("Check Player", typeof(bool), "Extended", "If true, the collapse direction is determined by the player's X speed (floors only).", null,
				(obj) => { return (obj.SubType & 0x40) == 0x40; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x40) | ((bool)value ? 0x40 : 0x00)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
