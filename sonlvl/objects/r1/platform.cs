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

		public override Sprite Image
		{
			get { return img_platform[0]; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			subtype &= 3;
			if (subtype < img_platform.Length)
				return img_platform[subtype];
			return ObjectHelper.UnknownObject;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			List<Sprite> sprs = new List<Sprite>();

			if (((SCDObjectEntry)obj).SubType2 != 0)
			{
				Sprite tmp = new Sprite(img_spring[(((SCDObjectEntry)obj).SubType2 >> 1) & 1]);
				tmp.Offset(new Point(0, -16));
				sprs.Add(tmp);
			}
			sprs.Add(new Sprite(SubtypeImage(obj.SubType), obj.XFlip, obj.YFlip));

			return new Sprite(sprs.ToArray());
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 2;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Size", typeof(int), "Extended", "The size of the platform.", null, new Dictionary<string, int>
				{
					{ "Small", 0 },
					{ "Medium", 1 },
					{ "Large", 2 }
				},
				(obj) => { return obj.SubType & 3; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~3) | ((int)value & 3))),

			new PropertySpec("Range", typeof(int), "Extended", "The platform's range of motion.", null, new Dictionary<string, int>
				{
					{ "32px", 0 },
					{ "48px", 1 },
					{ "64px", 2 },
					{ "96px", 3 }
				},
				(obj) => { return (obj.SubType & 0xC) >> 2; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0xC) | (((int)value & 3) << 2))),

			new PropertySpec("Direction", typeof(int), "Extended", "The platform's direction of motion.", null, new Dictionary<string, int>
				{
					{ "Vertical", 0 },
					{ "Horizontal", 1 },
					{ "Diagonal (Up Left -> Down Right)", 2 },
					{ "Diagonal (Up Right -> Down Left)", 3 },
					{ "Stationary", 4 },
					{ "Down (When Stood On)", 5 },
					{ "Nudge Up (When Stood On)", 6 },
					{ "Up (When Stood On)", 7 },
					{ "Nudge Right (When Stood On)", 8 },
					{ "Nudge Left (When Stood On)", 9 }
				},
				(obj) => { return (obj.SubType & 0xF0) >> 4; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0xF0) | (((int)value & 0xF) << 4))),

			new PropertySpec("Spring", typeof(bool), "Extended", "If true, a spring is placed on top of the platform.", null,
				(obj) => { return (((SCDObjectEntry)obj).SubType2 & 1) == 1; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~1) | ((bool)value ? 1 : 0))),

			new PropertySpec("Spring Color", typeof(int), "Extended", "The color of the platform's spring, if it exists.", null, new Dictionary<string, int>
				{
					{ "Red", 0 },
					{ "Yellow", 1 },
				},
				(obj) => { return (((SCDObjectEntry)obj).SubType2 & 2) >> 1; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~2) | (((int)value & 1) << 1)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
