using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	public class MetalSonicHologram : ObjectDefinition
	{
		private struct AnimalData
		{
			public Sprite sprite;
			public Point offset;

			public AnimalData(Sprite sprite, Point offset, bool x_flip)
			{
				this.sprite = new Sprite(sprite, x_flip, false);
				this.offset = offset;
			}
		}

		private Sprite img_projector;
		private Sprite img_light;
		private Sprite img_metal_sonic;
		private Point[] metal_sonic_offsets;
		private AnimalData[,] animals;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/hologram.nem", CompressionType.Nemesis);
			img_projector = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 0, 0);
			img_light = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 2, 0);
			img_metal_sonic = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 5, 0);
		
			metal_sonic_offsets = new Point[6];
			animals = new AnimalData[6, 2];

			// R1
			metal_sonic_offsets[0] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/hologram_animals.nem", CompressionType.Nemesis);
			animals[0, 0] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[0, 1] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_2.asm", 4, 0),
				new Point(-100, 4),
				true);

			// R3
			metal_sonic_offsets[1] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r3/hologram_animals.nem", CompressionType.Nemesis);
			animals[1, 0] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[1, 1] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_2.asm", 4, 0),
				new Point(-98, 0),
				true);

			// R4
			metal_sonic_offsets[2] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r4/animals.nem", CompressionType.Nemesis);
			animals[2, 0] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_1.asm", 0, 0),
				new Point(-108, -28),
				false);
			animals[2, 1] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_2.asm", 0, 1),
				new Point(-52, -17),
				true);

			// R5
			metal_sonic_offsets[3] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r5/hologram_animals.nem", CompressionType.Nemesis);
			animals[3, 0] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[3, 1] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_2.asm", 4, 0),
				new Point(-100, 4),
				true);

			// R6
			metal_sonic_offsets[4] = new Point(-72, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r6/hologram_animals.nem", CompressionType.Nemesis);
			animals[4, 0] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_1.asm", 1, 0),
				new Point(-40, -24),
				true);
			animals[4, 1] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_2.asm", 4, 0),
				new Point(-84, 7),
				false);

			// R7
			metal_sonic_offsets[5] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r7/hologram_animals.nem", CompressionType.Nemesis);
			animals[5, 0] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[5, 1] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_2.asm", 4, 0),
				new Point(-98, 0),
				true);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return "Metal Sonic Hologram"; }
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
			get { return img_projector; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return img_projector;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			List<Sprite> sprs = new List<Sprite>();
			sprs.Add(new Sprite(img_projector, obj.XFlip, obj.YFlip));

			Sprite tmp = new Sprite(img_light);
			tmp.Offset(new Point(-21, -7));
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(animals[LevelData.Level.Zone, 1].sprite);
			tmp.Offset(animals[LevelData.Level.Zone, 1].offset);
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(img_metal_sonic);
			tmp.Offset(metal_sonic_offsets[LevelData.Level.Zone]);
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(animals[LevelData.Level.Zone, 0].sprite);
			tmp.Offset(animals[LevelData.Level.Zone, 0].offset);
			sprs.Add(new Sprite(tmp));

			return new Sprite(sprs.ToArray());
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}
	}
}
