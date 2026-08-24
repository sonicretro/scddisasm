using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	struct AnimalData
	{
		public Sprite sprite;
		public Point offset;
		public bool x_flip;

		public AnimalData(Sprite sprite, Point offset, bool x_flip)
		{
			this.sprite = sprite;
			this.offset = offset;
			this.x_flip = x_flip;
		}
	}

	public class MetalSonicHologram : ObjectDefinition
	{
		private Sprite img_projector;
		private Sprite img_light;
		private Sprite img_metal_sonic;
		private Point[] offsets;
		private AnimalData[] animals;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/hologram.nem", CompressionType.Nemesis);
			img_projector = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 0, 0);
			img_light = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 2, 0);
			img_metal_sonic = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 5, 0);
		
			offsets = new Point[6];
			animals = new AnimalData[12];

			offsets[0] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/hologram_animals.nem", CompressionType.Nemesis);
			animals[0] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[1] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_2.asm", 4, 0),
				new Point(-100, 4),
				true);

			offsets[1] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r3/hologram_animals.nem", CompressionType.Nemesis);
			animals[2] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[3] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_2.asm", 4, 0),
				new Point(-98, 0),
				true);

			offsets[2] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r4/animals.nem", CompressionType.Nemesis);
			animals[4] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_1.asm", 0, 0),
				new Point(-108, -28),
				false);
			animals[5] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_2.asm", 0, 1),
				new Point(-52, -17),
				true);

			offsets[3] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r5/hologram_animals.nem", CompressionType.Nemesis);
			animals[6] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[7] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_2.asm", 4, 0),
				new Point(-100, 4),
				true);

			offsets[4] = new Point(-72, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r6/hologram_animals.nem", CompressionType.Nemesis);
			animals[8] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_1.asm", 1, 0),
				new Point(-40, -24),
				true);
			animals[9] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_2.asm", 4, 0),
				new Point(-84, 7),
				false);

			offsets[5] = new Point(-88, -4);
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r7/hologram_animals.nem", CompressionType.Nemesis);
			animals[10] = new AnimalData(
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_1.asm", 1, 0),
				new Point(-56, -24),
				true);
			animals[11] = new AnimalData(
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
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
		}

		public Sprite SetupSprite(int zone)
		{
			AnimalData animal_1 = animals[zone * 2];
			AnimalData animal_2 = animals[(zone * 2) + 1];
			
			List<Sprite> sprs = new List<Sprite>();
			sprs.Add(new Sprite(img_projector));

			Sprite tmp = new Sprite(img_light);
			tmp.Offset(new Point(-21, -7));
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(animal_2.sprite, animal_2.x_flip, false);
			tmp.Offset(animal_2.offset);
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(img_metal_sonic);
			tmp.Offset(offsets[zone]);
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(animal_1.sprite, animal_1.x_flip, false);
			tmp.Offset(animal_1.offset);
			sprs.Add(new Sprite(tmp));

			return new Sprite(sprs.ToArray());
		}

		public override Sprite Image
		{
			get { return SetupSprite(0); }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return SetupSprite(0);
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return SetupSprite(LevelData.Level.Zone);
		}
	}
}