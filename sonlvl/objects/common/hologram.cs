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
			public Sprite img;
			public Point offset;

			public AnimalData(Sprite img, Point offset, bool x_flip)
			{
				this.img = new Sprite(img, x_flip, false);
				this.offset = offset;
			}
		}

		private Sprite img_projector;
		private Sprite img_light;
		private Sprite img_metal_sonic;

		private Point metal_sonic_offset;
		private AnimalData[] animals;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/hologram.nem", CompressionType.Nemesis);
			img_projector = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 0, 0);
			img_light = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 2, 0);
			img_metal_sonic = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/hologram.asm", 5, 0);
		
			animals = new AnimalData[2];

			switch (LevelData.Level.Zone)
			{
				case 0:
					metal_sonic_offset = new Point(-88, -4);
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/hologram_animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_1.asm", 1, 0),
						new Point(-56, -24),
						true);
					animals[1] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_2.asm", 4, 0),
						new Point(-100, 4),
						true);
					break;

				case 1:
					metal_sonic_offset = new Point(-88, -4);
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r3/hologram_animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_1.asm", 1, 0),
						new Point(-56, -24),
						true);
					animals[1] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_2.asm", 4, 0),
						new Point(-98, 0),
						true);
					break;

				case 2:
					metal_sonic_offset = new Point(-88, -4);
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r4/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_1.asm", 0, 0),
						new Point(-108, -28),
						false);
					animals[1] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_2.asm", 0, 1),
						new Point(-52, -17),
						true);
					break;

				case 3:
					metal_sonic_offset = new Point(-88, -4);
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r5/hologram_animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_1.asm", 1, 0),
						new Point(-56, -24),
						true);
					animals[1] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_2.asm", 4, 0),
						new Point(-100, 4),
						true);
					break;

				case 4:
					metal_sonic_offset = new Point(-72, -4);
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r6/hologram_animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_1.asm", 1, 0),
						new Point(-40, -24),
						true);
					animals[1] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_2.asm", 4, 0),
						new Point(-84, 7),
						false);
					break;

				case 5:
					metal_sonic_offset = new Point(-88, -4);
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r7/hologram_animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_1.asm", 1, 0),
						new Point(-56, -24),
						true);
					animals[1] = new AnimalData(
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_2.asm", 4, 0),
						new Point(-98, 0),
						true);
					break;
			}
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

			tmp = new Sprite(animals[1].img);
			tmp.Offset(animals[1].offset);
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(img_metal_sonic);
			tmp.Offset(metal_sonic_offset);
			sprs.Add(new Sprite(tmp));

			tmp = new Sprite(animals[0].img);
			tmp.Offset(animals[0].offset);
			sprs.Add(new Sprite(tmp));

			return new Sprite(sprs.ToArray());
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}
	}
}
