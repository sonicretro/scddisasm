using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class Platform : ObjectDefinition
	{
		private Sprite[] img_platform = new Sprite[3];
		private Sprite[] img_spring = new Sprite[2];

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/platform.nem", CompressionType.Nemesis);
			img_platform[0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/platform.asm", 0, 2);
			img_platform[1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/platform.asm", 1, 2);
			img_platform[2] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/platform.asm", 2, 2);

			art_file = ObjectHelper.OpenArtFile("../src/gfx/spring.nem", CompressionType.Nemesis);
			img_spring[0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/spring.asm", ".VSprite0", 0);
			img_spring[1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/spring.asm", ".VSprite0", 1);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return "Platform"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
		}

		public Sprite SetupSprite(byte subtype, byte subtype2)
		{
			List<Sprite> sprs = new List<Sprite>();

			if (subtype2 > 0)
			{
				Sprite tmp = new Sprite(img_spring[subtype2 >> 1]);
				tmp.Offset(new Point(0, -16));
				sprs.Add(tmp);
			}
			sprs.Add(new Sprite(img_platform[Math.Min(2, subtype & 3)]));

			return new Sprite(sprs.ToArray());
		}

		public override Sprite Image
		{
			get { return SetupSprite(0, 0); }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return SetupSprite(subtype, 0);
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return SetupSprite(obj.SubType, ((SCDObjectEntry)obj).SubType2);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 2;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Size", typeof(int), "Extended", "The size of the platform", null, new Dictionary<string, int>
				{
					{ "Small", 0x00 },
					{ "Medium", 0x01 },
					{ "Large", 0x02 }
				},
				(obj) => { return Math.Min(obj.SubType & 0x03, 0x02); },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x03) | ((int)value & 0x03))),

			new PropertySpec("Range", typeof(int), "Extended", "The platform's range of motion.", null, new Dictionary<string, int>
				{
					{ "32px", 0x00 },
					{ "48px", 0x01 },
					{ "64px", 0x02 },
					{ "96px", 0x03 }
				},
				(obj) => { return (obj.SubType & 0x0C) >> 2; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x0C) | (((int)value & 0x03) << 2))),

			new PropertySpec("Direction", typeof(int), "Extended", "The platform's direction of motion.", null, new Dictionary<string, int>
				{
					{ "Vertical", 0x00 },
					{ "Horizontal", 0x01 },
					{ "Diagonal (Up Left -> Down Right)", 0x02 },
					{ "Diagonal (Up Right -> Down Left)", 0x03 },
					{ "Stationary", 0x04 },
					{ "Down (When Stood On)", 0x05 },
					{ "Nudge Up (When Stood On)", 0x06 },
					{ "Up (When Stood On)", 0x07 },
					{ "Nudge Right (When Stood On)", 0x08 },
					{ "Nudge Left (When Stood On)", 0x09 }
				},
				(obj) => { return (obj.SubType & 0xF0) >> 4; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0xF0) | (((int)value & 0x0F) << 4))),

			new PropertySpec("Spring", typeof(bool), "Extended", "If true, a spring is placed on top of the platform.", null,
				(obj) => { return (((SCDObjectEntry)obj).SubType2 & 0x01) == 0x01; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~0x01) | ((bool)value ? 0x01 : 0x00))),

			new PropertySpec("Spring Color", typeof(int), "Extended", "The color of the platform's spring, if it exists.", null, new Dictionary<string, int>
				{
					{ "Red", 0x00 },
					{ "Yellow", 0x01 },
				},
				(obj) => { return (((SCDObjectEntry)obj).SubType2 & 0x02) >> 1; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~0x02) | (((int)value & 0x01) << 1)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
